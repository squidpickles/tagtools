CXX=c++
CONF=`taglib-config --libs --cflags`

all: retag tagdump cptag

retag: retag.cpp
	${CXX} ${CONF} -o $@ $<

cptag: cptag.cpp
	${CXX} ${CONF} -o $@ $<

tagdump: tagdump.cpp
	${CXX} ${CONF} -o $@ $<

clean:
	rm -f retag tagdump cptag
