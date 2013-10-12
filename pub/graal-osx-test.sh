#!/bin/bash
# Download Graal
hg clone http://hg.openjdk.java.net/graal/graal
cd graal

# Compile sample code
echo 'public class Application { public static void main(String[] args) { System.out.println("Hello, world"); } }' > Application.java
javac Application.java

# Compile Graal
echo "JAVA_HOME=`/usr/libexec/java_home -v 1.7`" > mx/env
./mx.sh build fastdebug

# Run sample
time ./mx.sh --fastdebug vm -XX:-BootstrapGraal Application