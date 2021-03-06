.SUFFIXES: .x86_64_o .x86_32_o .win_x86_32_o .win_x86_64_o .mac_os_o

SOURCES=main.c

# default
CC=gcc
CFLAGS=-c -Wall
LDFLAGS=
OBJECTS=$(SOURCES:.c=.o)
EXECUTABLE=hello-world

# Linux x86_64
CC_X86_64=gcc
CFLAGS_X86_64=$(CFLAGS)
LDFLAGS_X86_64=$(LDFLAGS)
OBJECTS_X86_64=$(SOURCES:.c=.x86_64_o)
EXECUTABLE_X86_64=hello-world_linux_x86_64

# Linux x86_32
CC_X86_32=gcc
CFLAGS_X86_32=$(CFLAGS) -m32
LDFLAGS_X86_32=$(LDFLAGS) -m32
OBJECTS_X86_32=$(SOURCES:.c=.x86_32_o)
EXECUTABLE_X86_32=hello-world_linux_x86_32

# Windows x86_32
CC_WIN_X86_32=i686-w64-mingw32-gcc
CFLAGS_WIN_X86_32=$(CFLAGS)
LDFLAGS_WIN_X86_32=$(LDFLAGS)
OBJECTS_WIN_X86_32=$(SOURCES:.c=.win_x86_32_o)
EXECUTABLE_WIN_X86_32=hello-world_windows_x86_32.exe

# Windows x86_64
CC_WIN_X86_64=x86_64-w64-mingw32-gcc
CFLAGS_WIN_X86_64=$(CFLAGS)
LDFLAGS_WIN_X86_64=$(LDFLAGS)
OBJECTS_WIN_X86_64=$(SOURCES:.c=.win_x86_64_o)
EXECUTABLE_WIN_X86_64=hello-world_windows_x86_64.exe

# macOS
CC_MAC_OS=gcc
CFLAGS_MAC_OS=$(CFLAGS)
LDFLAGS_MAC_OS=$(LDFLAGS)
OBJECTS_MAC_OS=$(SOURCES:.c=.mac_os_o)
EXECUTABLE_MAC_OS=hello-world_mac_os

# Default platform
all: $(SOURCES) $(EXECUTABLE)
	rm *.o

# Build for every platform at once (except macOS)
build: $(SOURCES) $(EXECUTABLE_X86_64) $(EXECUTABLE_X86_32) $(EXECUTABLE_X86_64) $(EXECUTABLE_WIN_X86_32) $(EXECUTABLE_WIN_X86_64)
	rm *.x86_64_o *.x86_32_o *.win_x86_32_o *.win_x86_64_o

# Build macOS
build_mac_os: $(SOURCES) $(EXECUTABLE_MAC_OS)
	rm *.mac_os_o

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@

# Linux x86_64
$(EXECUTABLE_X86_64): $(OBJECTS_X86_64)
	$(CC_X86_64) $(LDFLAGS_X86_64) $(OBJECTS_X86_64) -o $@

# Linux x86_32
$(EXECUTABLE_X86_32): $(OBJECTS_X86_32)
	$(CC_X86_32) $(LDFLAGS_X86_32) $(OBJECTS_X86_32) -o $@

# Windows x86_32
$(EXECUTABLE_WIN_X86_32): $(OBJECTS_WIN_X86_32)
	$(CC_WIN_X86_32) $(LDFLAGS_WIN_X86_32) $(OBJECTS_WIN_X86_32) -o $@

# Windows x86_64
$(EXECUTABLE_WIN_X86_64): $(OBJECTS_WIN_X86_64)
	$(CC_WIN_X86_64) $(LDFLAGS_WIN_X86_64) $(OBJECTS_WIN_X86_64) -o $@

# macOS
$(EXECUTABLE_MAC_OS): $(OBJECTS_MAC_OS)
	$(CC_MAC_OS) $(LDFLAGS_MAC_OS) $(OBJECTS_MAC_OS) -o $@

.c.o:
	$(CC) $(CFLAGS) $< -o $@

.c.x86_64_o:
	$(CC_X86_64) $(CFLAGS_X86_64) $< -o $@

.c.x86_32_o:
	$(CC_X86_32) $(CFLAGS_X86_32) $< -o $@

.c.win_x86_32_o:
	$(CC_WIN_X86_32) $(CFLAGS_WIN_X86_32) $< -o $@

.c.win_x86_64_o:
	$(CC_WIN_X86_64) $(CFLAGS_WIN_X86_64) $< -o $@

.c.mac_os_o:
	$(CC_MAC_OS) $(CFLAGS_MAC_OS) $< -o $@

clean:
	rm $(EXECUTABLE)

build_clean:
	rm $(EXECUTABLE_X86_64) $(EXECUTABLE_X86_32) $(EXECUTABLE_WIN_X86_32) $(EXECUTABLE_WIN_X86_64)

build_mac_os_clean:
	rm $(EXECUTABLE_MAC_OS)
