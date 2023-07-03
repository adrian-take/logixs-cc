#include <emscripten.h>

#include <vector>
#include "ezc3d.h"
#include "Header.h"
#include "Data.h"
#include "Parameters.h"

int readWriteC3d(std::string path)
{
    // Read an existing c3d file
    ezc3d::c3d c3d(path);

    // Add two new points to the c3d (one filled with zeros, the other one with data)
    c3d.point("new_point1"); // Add empty
    std::vector<ezc3d::DataNS::Frame> frames_point;
    ezc3d::DataNS::Points3dNS::Points pts_new;
    ezc3d::DataNS::Points3dNS::Point pt_new;
    pt_new.x(1.0);
    pt_new.y(2.0);
    pt_new.z(3.0);
    pts_new.point(pt_new);
    for (size_t i=0; i<c3d.data().nbFrames(); ++i){
        ezc3d::DataNS::Frame frame;
        frame.add(pts_new);
        frames_point.push_back(frame);
    }
    c3d.point("new_point2", frames_point); // Add the previously created

    // Add a new analog to the c3d (one filled with zeros, the other one with data)
    c3d.analog("new_analog1"); // add the empty
    std::vector<ezc3d::DataNS::Frame> frames_analog;
    ezc3d::DataNS::Frame frame;
    for (size_t sf = 0; sf < c3d.header().nbAnalogByFrame(); ++sf){
        ezc3d::DataNS::AnalogsNS::Channel newChannel;
        newChannel.data(sf+1);
        ezc3d::DataNS::AnalogsNS::SubFrame subframes_analog;
        subframes_analog.channel(newChannel);
        frame.analogs().subframe(subframes_analog);
    }
    for (size_t f=0; f<c3d.data().nbFrames(); ++f)
        frames_analog.push_back(frame);
    c3d.analog("new_analogs2", frames_analog);

    // Add a new frame
    ezc3d::DataNS::Frame f;
    std::vector<std::string>labels(c3d.parameters().group("POINT").parameter("LABELS").valuesAsString());
    int nPoints(c3d.parameters().group("POINT").parameter("USED").valuesAsInt()[0]);
    ezc3d::DataNS::Points3dNS::Points pts;
    for (size_t i=0; i<static_cast<size_t>(nPoints); ++i){
        ezc3d::DataNS::Points3dNS::Point pt;
        pt.x(1.0);
        pt.y(2.0);
        pt.z(3.0);
        pts.point(pt);
    }
    ezc3d::DataNS::AnalogsNS::Analogs analog;
    ezc3d::DataNS::AnalogsNS::SubFrame subframe;
    for (size_t i = 0; i < c3d.header().nbAnalogs(); ++i){
        ezc3d::DataNS::AnalogsNS::Channel c;
        c.data(i+1);
        subframe.channel(c);
    }
    for (size_t i = 0; i < c3d.header().nbAnalogByFrame(); ++i)
        analog.subframe(subframe);
    f.add(pts, analog);
    c3d.frame(f);


    // Add new parameters
    ezc3d::ParametersNS::GroupNS::Parameter p1("new_param_1");
    p1.set(std::vector<int>() = {2});
    c3d.parameter("new_group_1", p1);
    ezc3d::ParametersNS::GroupNS::Parameter p2("new_param_2");
    p2.set(std::vector<int>() = {1, 1, 2, 3, 5, 8}, {3, 2}); // TESTER LE READER DANS MATLAB!
    c3d.parameter("new_group_1", p2);
    ezc3d::ParametersNS::GroupNS::Parameter p3("new_param_1");
    p3.set(std::vector<std::string>() = {"value1", "longer_value1", "value2", "longer_value2"}, {2, 2});
    c3d.parameter("new_group_2", p3);

    // write the changed c3d
    c3d.write("./temp/augmentedC3d.c3d");

    // Read it back!
    ezc3d::c3d augmentedC3d("./temp/augmentedC3d.c3d");
    //augmentedC3d.parameters().print();

    return 0;
}

int readC3d(std::string fullpath)
{
    // Read an existing c3d file
    ezc3d::c3d c3d(fullpath);

    // Add two new points to the c3d (one filled with zeros, the other one with data)
    c3d.point("new_point1"); // Add empty
    std::vector<ezc3d::DataNS::Frame> frames_point;
    ezc3d::DataNS::Points3dNS::Points pts_new;
    ezc3d::DataNS::Points3dNS::Point pt_new;
    pt_new.x(1.0);
    pt_new.y(2.0);
    pt_new.z(3.0);
    pts_new.point(pt_new);
    for (size_t i=0; i<c3d.data().nbFrames(); ++i){
        ezc3d::DataNS::Frame frame;
        frame.add(pts_new);
        frames_point.push_back(frame);
    }
    c3d.point("new_point2", frames_point); // Add the previously created

    return 0;
}

void createC3d()
{
    // Create an empty fresh c3d
    try { 
        ezc3d::c3d c3d_empty;

        ezc3d::ParametersNS::GroupNS::Parameter t("SCALE");
        t.set(std::vector<double>(), {0});
        c3d_empty.parameter("POINT", t);

        // Fill it with some values
        ezc3d::ParametersNS::GroupNS::Parameter pointRate("RATE");
        pointRate.set(std::vector<double>() = {100}, {1});
        c3d_empty.parameter("POINT", pointRate);

        ezc3d::ParametersNS::GroupNS::Parameter analogRate("RATE");
        analogRate.set(std::vector<double>() = {1000}, {1});
        c3d_empty.parameter("ANALOG", analogRate);

        c3d_empty.point("new_point1"); // Add empty
        c3d_empty.point("new_point2"); // Add empty
        c3d_empty.analog("new_analog1"); // add the empty
        c3d_empty.analog("new_analog2"); // add the empty
        // Add a new frame
        ezc3d::DataNS::Frame f;
        std::vector<std::string> labels(c3d_empty.parameters().group("POINT").parameter("LABELS").valuesAsString());
        int nPoints(c3d_empty.parameters().group("POINT").parameter("USED").valuesAsInt()[0]);
        ezc3d::DataNS::Points3dNS::Points pts;
        for (size_t i=0; i<static_cast<size_t>(nPoints); ++i){
            ezc3d::DataNS::Points3dNS::Point pt;
            pt.x(1.0);
            pt.y(2.0);
            pt.z(3.0);
            pts.point(pt);
        }
        ezc3d::DataNS::AnalogsNS::Analogs analog;
        ezc3d::DataNS::AnalogsNS::SubFrame subframe;
        for (size_t i = 0; i < c3d_empty.header().nbAnalogs(); ++i){
            ezc3d::DataNS::AnalogsNS::Channel c;
            c.data(i+1);
            subframe.channel(c);
        }
        for (size_t i = 0; i < c3d_empty.header().nbAnalogByFrame(); ++i)
            analog.subframe(subframe);
        f.add(pts, analog);
        c3d_empty.frame(f);
        c3d_empty.frame(f);

        // Write the brand new c3d
        c3d_empty.write("/temp/emptyC3d.c3d");

        // Read it back!
        ezc3d::c3d emptyC3d("/temp/emptyC3d.c3d");
        emptyC3d.parameters().print();
    }
    catch (const std::exception &exc)
    {
        // catch anything thrown within try block that derives from std::exception
        printf("exception:");
        std::cout << exc.what();
    }
}

inline const char* cstr(const std::string& message) {
    char * cstr = new char [message.length()+1];
    std::strcpy (cstr, message.c_str());
    return cstr;
}

std::string vectorToString(std::vector<float> &data) {
    std::string dataStr = "[";
    for(int i=0; i < data.size(); i++){
        dataStr += std::to_string(data[i]);
        if (i <  (data.size() - 1))
           dataStr += ",";
    }
    dataStr += "]";
    return dataStr;
}

std::string getJsonObj() {
    std::vector<float>data({1.432, 1, 2, 3, 5, 8, 1.432, 1, 2, 3, 5, 8, 1.432, 1, 2, 3, 5, 8 });
    std::string dataStr = vectorToString(data);
    std::string str = "[{ \"label\": \"POINTS\", \"X\":" + dataStr + ", \"Y\":" + dataStr + ", \"Z\":" + dataStr + "}, \
                        { \"label\": \"ANALOG\", \"X\":" + dataStr + ", \"Y\":" + dataStr + ", \"Z\":" + dataStr + "}, \
                        { \"label\": \"FORCE\", \"X\":" + dataStr + ", \"Y\":" + dataStr + ", \"Z\":" + dataStr + "} ]";
    return str;
}

extern "C" {

EMSCRIPTEN_KEEPALIVE
const char* testReadWriteC3d(char* filename) { 
    EM_ASM(
        //ATTENTION: this code expects to find a variable named 'dir' which contains filename
        FS.mkdir('/temp'); 
        FS.mount(NODEFS, {root : dir}, '/temp'); 
     );

    readWriteC3d(std::string("/temp/") + std::string(filename));
    return "";
}

EMSCRIPTEN_KEEPALIVE
const char* testReadC3d(char* filename) { 
    EM_ASM(
        //ATTENTION: this code expects to find a variable named 'dir' which contains filename
        FS.mkdir('/temp'); 
        FS.mount(NODEFS, {root : dir}, '/temp'); 
     );

    readC3d(std::string("/temp/") + std::string(filename));

    std::string json = getJsonObj();
    return cstr(json);
}

EMSCRIPTEN_KEEPALIVE
const char* testMessage(const char* path) { 
    std::string json = getJsonObj();
    return path;
}

}