CONF=$(shell pkg-config --libs --cflags taglib)

all: retag tagdump cptag

retag: retag.cpp
	${CXX} ${CXXFLAGS} ${LDFLAGS} -o $@ $< ${CONF}

cptag: cptag.cpp
	${CXX} ${CXXFLAGS} ${LDFLAGS} -o $@ $< ${CONF}

tagdump: tagdump.cpp
	${CXX} ${CXXFLAGS} ${LDFLAGS} -o $@ $< ${CONF}

clean:
	rm -f retag tagdump cptag
