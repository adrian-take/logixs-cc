# Assignment for Cloud Engineer

## Background

The history of movement analysis’ HW technologies, in combination with the large amount of data captured by these measurement devices (high-frequency and multi-channel) brought HW manufactures to develop and maintain proprietary binary data formats, often open-sourcing their implementation to facilitate their adoption by the data science and research community. The most popular one is C3D (read more on https://www.c3d.org/).

Moveshelf is working to bridge the technological gap between measurement HW devices and modern web application, for digital healthcare.
As a result, our team is often challenged with working with such existing binary data formats and C/C++ libraries developed as interfaces to abstract complexity in the interaction.

A package to process C3D files in Python is [**py-c3d**](https://github.com/EmbodiedCognition/py-c3d).

# Your assignment

Your task is to implement a basic cloud application that can:

* Store C3D files
* Process C3D files
* Store processed C3D files' contents for later consumptions

To achieve this, it is required to use Google cloud, leveraging only free tier services.
<!-- Notes about how to create an account and what is needed, such as a valid card -->

In particular, the application will be made of the following components:

* A service to store the C3D files (`c3d-storage`). It is fine to manually upload the C3D files in here, no need for automation
* A service to store json files produced by the processing of the C3D files (`json-storage`)
* A service that exposes a REST API that will,
  1. Implement a basic endpoint written in Python that accepts the path for a C3D file that needs processing
  2. Look for the C3D file path in `c3d-storage`, where the C3D file was previously uploaded
  3. Parse the C3D file, extract its content and then save it as a human readable .json file in `json-storage`. See [Processing of C3D files](#processing-of-c3d-files) for details

Additionally, the following restrictions must be satisfied:

* For security reasons, the API can read (but not write) files from `c3d-storage`
* For security reasons, the API can write (but not list nor read) files from `json-storage`

The candidate is free to decide what services to use, granted they comply with the free tier.

The candidate is free to decide what form of authentication to use for the services.

Additionally, the candidate should provide a Terraform configuration to allow an easy way to create
and destroy the application. You are allowed to apply any related best practice in doing so.
**Keep in mind that we will use this Terraform configuration to test your submission.**

## Bonus points

* Produce a cloud architecture diagram that explains what services are used and how they are connected.
  You can use any free tool, such as https://app.diagrams.net/
* Implement a REST endpoint to allow the upload of a C3D file into `c3d-storage`
* Implement a REST endpoint to allow the fetch of a processed C3D file from `json-storage`
* Implement a local frontend that interfaces with the endpoint(s) and displays the json contents.
  This should not be included in the Terraform configuration, a simple frontend that can be served
  locally is sufficient (such as html+js)

# Processing of C3D files

* An example c3d file is provided in https://github.com/moveshelf/cloud-eng-assignment-1/blob/main/example_file.c3d.
* The file is converted to JSON using https://c3d.readthedocs.io/en/stable/, see below for example code to extract data and convert to json.
* The processing should return the status, e.g. a 200 OK if success or 400/500 on failure.

```py

import c3d
import json

reader = c3d.Reader(open(r'<path>\example_file.c3d', 'rb'))

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
with open(r'<path>\example_file.json', 'w') as json_file:
    json.dump(outData, json_file)

```

# Note and tips

* The assignment is expected to be completed within 8 hours.
* It’s OK to spend extra time but it’s also OK - and expected - that candidates prioritize work and complete a "Proof-of-Concept" in the simplest way possible.
* Boilerplate code and helper libraries that can potentially reduce complexity of the assignment, while achieving the mentioned goal, are welcome.
* You are free – and encouraged – to adopt any best practices related to software development, used frameworks/libraries and tooling you know
* Don't overcomplicate the infrastructure, stick to basic services available in the free tier
