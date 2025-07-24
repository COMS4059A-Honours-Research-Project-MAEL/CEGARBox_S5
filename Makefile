CC = g++
CFLAGS = -std=c++17 -Wall -g -O3 -mavx2 -fopenmp -static 
CFLAGS += -I/usr/local/include/antlr4-runtime
LIBS = -L/usr/local/lib -lminisat -lantlr4-runtime 
SRCDIR = .

SOURCES = $(shell find $(SRCDIR) -name "*.cpp")

OBJECTS_MAIN = $(SOURCES:.cpp=.o)
EXECUTABLE_MAIN = CEGARBox_S5

all: $(EXECUTABLE_MAIN)

$(EXECUTABLE_MAIN): $(OBJECTS_MAIN)
	$(CC) $(CFLAGS) $^ -o $(EXECUTABLE_MAIN) $(LIBS)

.cpp.o:
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJECTS_MAIN) $(EXECUTABLE_MAIN) $(OBJECTS_LTLMAIN)
