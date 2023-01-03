CXX = g++
CC = gcc
CXXFLAGS = -std=c++20 -stdlib=libc++
LDFLAGS = -g
LIB = -lglfw

LIB_DIR = -L./lib -L./lib/GLFW # the . tells to look starting from the makefile directory
INCLUDE_DIR = -I./include

SRC_DIR = src
SRC := $(shell find $(SRC_DIR) -name "*.cpp") # search recursively in all subdirectories for all .cpp/.c files
SRCC = $(shell find $(SRC_DIR) -name "*.c")

OBJ_DIR = obj
OBJ = $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.cpp.o, $(SRC))
OBJC = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.c.o, $(SRCC))

BIN_DIR = bin

EXE = $(BIN_DIR)/app

DIR_DEP = $(sort $(dir $(OBJ))) $(sort $(dir $(OBJC))) # to create the whole directory tree from SRC_DIR in the OBJ_DIR

.PHONY: all run clean

all: $(DIR_DEP) $(EXE)

$(EXE) : $(OBJ) $(OBJC)
	$(CXX) $(LDFLAGS) $(LIB_DIR) $(LIB) $^ -o $@


$(OBJ_DIR)/%.cpp.o : $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $(INCLUDE_DIR) -o $@ -c $<

$(OBJ_DIR)/%.c.o : $(SRC_DIR)/%.c
	$(CC) $(INCLUDE_DIR) -o $@ -c $<


$(DIR_DEP):
	mkdir -p $@

run: $(EXE)
	./$(EXE)

clean:
	rm -rv $(BIN_DIR)/* $(OBJ_DIR)/*