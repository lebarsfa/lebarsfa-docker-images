FROM quay.io/pypa/manylinux2014_x86_64
RUN \
yum -y install wget flex bison doxygen graphviz && \
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
git clone -b actions https://github.com/lebarsfa/ibex-lib.git && \
cd ibex-lib && \
mkdir build && \
cd build && \
cmake -E env CXXFLAGS="-fPIC" CFLAGS="-fPIC" cmake .. && \
cmake --build . --target install && \
cd ../.. && \
rm -Rf ibex-lib
