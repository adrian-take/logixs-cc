from flask import escape
from google.cloud import storage

import functions_framework
import c3d
import json

@functions_framework.http
def handler(request):
    # define global constants and variables for function
    request_json = request.get_json(silent=True)
    originBucket = "ms-cs-c3d-storage"
    destinationBucket = "ms-cs-json-storage"

    # retrieve origin and destination paths
    originPath = ""
    destinationPath = ""
    if request_json and "originPath" in request_json:
        originPath = request_json["originPath"]
    if request_json and "destinationPath" in request_json:
        destinationPath = request_json["destinationPath"]
    if originPath == "" or destinationPath == "":
        return ("Please provide a originPath and destinationPath", 400)

    # retrieve c3d file and parse it
    try:
        c3dFile = getBlob(originBucket, originPath)
        jsonData = parseC3D(c3dFile)
    except Exception:
        return ("Failed to parse C3D file", 500)
    # write JSON file
    try:
        jsonFile = getBlob(destinationBucket, destinationPath)
        writeBlob(jsonFile, jsonData)
    except Exception:
        return ("Failed to write JSON file", 503)
    
    return ("Successfully parsed C3D file", 200)

def getBlob(bucketName, path):
    csClient = storage.Client()
    bucket = csClient.bucket(bucketName)
    blob = bucket.blob(path)
    return blob

def readBlob(blob):
    with blob.open("r") as f:
        return f.read()
    
def writeBlob(blob, data):
    with blob.open("w") as f:
        json.dump(data, blob)

def parseC3D(c3dFile):
    # reader = c3d.Reader(open(r'<path>\example_file.c3d', 'rb'))
    reader = c3d.Reader(c3dFile)

    labels = reader.point_labels
    fs = reader.point_rate

    # build dictionary with data
    dataDict = {}
    for label in labels:
        dataDict[label] = []

    # fill point data for 'Angles'
    for i, points, analog in reader.read_frames():
        for j, label in enumerate(labels):
            if 'Angle' in label:
                frame = {
                    'time': float(i/fs),
                    'x': float(points[j,0]),
                    'y': float(points[j,1]),
                    'z': float(points[j,2])
                }
                dataDict[label].append(frame)

    # prepare for json
    outData = {'data': []}
    for label in labels:
        outData['data'].append({'label': label, 'values': dataDict[label]})

    # write to json
    #with open(r'<path>\example_file.json', 'w') as json_file:
    #    json.dump(outData, json_file)

    return outData
