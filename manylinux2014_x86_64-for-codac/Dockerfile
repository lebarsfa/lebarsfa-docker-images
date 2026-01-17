FROM quay.io/pypa/manylinux2014_x86_64
RUN \
yum -y install sudo redhat-lsb-core file wget zip unzip git flex bison doxygen graphviz && \
\
wget https://gitlab.com/libeigen/eigen/-/archive/3.4.0/eigen-3.4.0.zip -nv && \
unzip -q -o eigen-3.4.0.zip && \
cd eigen-3.4.0 && \
mkdir build && \
cd build && \
cmake .. && \
cmake --build . --target install && \
cd ../.. && \
rm -Rf eigen-3.4.0.zip && \
rm -Rf eigen-3.4.0 && \
\
wget https://github.com/doxygen/doxygen/releases/download/Release_1_9_6/doxygen-1.9.6.src.tar.gz -nv && \
tar xfz doxygen-1.9.6.src.tar.gz && \
cd doxygen-1.9.6 && \
mkdir build && \
cd build && \
cmake .. && \
cmake --build . && \
cmake --build . --target install && \
cd ../.. && \
rm -Rf doxygen-1.9.6.src.tar.gz && \
rm -Rf doxygen-1.9.6
