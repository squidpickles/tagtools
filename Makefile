CONF=`taglib-config --libs --cflags`

all: retag tagdump cptag

retag: retag.cpp
	${CXX} ${CONF} ${CXXFLAGS} -o $@ $<

cptag: cptag.cpp
	${CXX} ${CONF} ${CXXFLAGS} -o $@ $<

tagdump: tagdump.cpp
	${CXX} ${CONF} ${CXXFLAGS} -o $@ $<

clean:
	rm -f retag tagdump cptag
