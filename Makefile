CONF=`taglib-config --libs --cflags`

all: retag tagdump cptag

retag: retag.cpp
	${CXX} ${CONF} ${CXXFLAGS} ${LDFLAGS} -o $@ $<

cptag: cptag.cpp
	${CXX} ${CONF} ${CXXFLAGS} ${LDFLAGS} -o $@ $<

tagdump: tagdump.cpp
	${CXX} ${CONF} ${CXXFLAGS} ${LDFLAGS} -o $@ $<

clean:
	rm -f retag tagdump cptag
