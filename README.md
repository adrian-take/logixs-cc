## Assignment for Cloud Engineer assignment

_Background:_     
      
The history of movement analysis’ HW technologies, in combination with the large amount of data captured by these measurement devices (high-frequency and multi-channel) brought HW manufactures to develop and maintain proprietary binary data formats, often open-sourcing their implementation to facilitate their adoption by the data science and research community. The most popular one is C3D (read more on https://www.c3d.org/). 

Moveshelf is working to bridge the technological gap between measurement HW devices and modern web application, for digital healthcare. As a result, our team is often challenged with working with such existing binary data formats and C/C++ libraries developed as interfaces to abstract complexity in the interaction. A popular one to work C3D is EZC3D (see also https://github.com/pyomeca/ezc3d).  
     
_Your assignment:_    
     
1 - Implement a minimal frontend (Angular) and backend (Python/Node) applications to: 
* Prompt the user an action trigger to select a c3d file from the filesystem of the local machine  
* Extract a 3D point/trajectory from the c3d file by using the mentioned library (and/or any helper file provided in the assignment)  
* Presents results to the user, to show highlights of the content in a human readable format  
     
2 - Implement infrastructure code (Terraform) that can be used to declare the necessary infrastructure (GCP):     
3 - Describe/implement any additional missing component that would be required to complete a minimal CI/CD setup that could be use to reliably and repeadetely maintain/update the application.  
     
     
_Note and tips:_    
* The assignment is expected to be completed within 8 hours.  
* It’s OK to spend extra time but it’s also OK - and expected - that candidates prioritize work and complete a "Proof-of-Concept" in the simplest way possible. 
* Boilerplate code and helper libraries that can potentially reduce complexity of the assignment, while achieving the mentioned goal, are welcome.   
* ```testEzC3dWasm.js``` is provided to show a possible basic interaction between the library and a WASM/JS wrapper. Try calling  ```node testEzC3dWasm.js``` to get started with testing. Be aware that ```testReadC3d(filename)``` uses the global variable 'dir' to concatenate the fullpath of the provided filename. Be aware that such wrapper requires access to file system using node module (https://nodejs.org/api/fs.html). Any alternative implementation/library that prove capability of accessing content of C3D files is considered OK. 
* You are free – and encouraged – to adopt any best practices related to software development, used frameworks/libraries and tooling you know

