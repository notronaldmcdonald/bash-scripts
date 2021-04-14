#!/usr/bin/env bash
# cpuinfo - Fetches information on your CPU.
# Developed by Brett. (https://github.com/notronaldmcdonald)

# begin script
function getvendor() {
  # get vendor
  if [ $(cat /proc/cpuinfo | grep -o "AuthenticAMD" | head -n 1) != "" ]; then
    vendor="Advanced Micro Devices (AuthenticAMD)"
  elif [ $(cat /proc/cpuinfo | grep -o "GenuineIntel" | head -n 1) != "" ]; then
    vendor="Intel Corporation (GenuineIntel)"
  else
    vendor="Unknown (Unknown)"
  fi
}

function getname() {
  # get the cpu name
  cpuname=$(cat /proc/cpuinfo | grep -w "model name" | head -n 1 | sed -r 's/^.{13}//')
}

function getcpus() {
  # get the number of physical and logical cores
  cpus_p=$(lscpu | grep -w "Core(s) per socket" | sed -r 's/^.{33}//')
  # get logical cpus
  function getlogical() {
    mult=$(lscpu | grep -w "Thread(s) per core" | sed -r 's/^.{33}//')
    cpus_l=$(expr $cpus_p \* $mult)
  }
  getlogical
}

function getclocks() {
  # get the clock speed entries (avg. clock, fastest core, slowest core)
  clock_fastest=$(sort -n /proc/cpuinfo | grep -w "cpu MHz" | tail -n 1 | sed -r 's/^.{11}//')
  clock_slowest=$(sort -n /proc/cpuinfo | grep -w "cpu MHz" | head -n 1 | sed -r 's/^.{11}//')
}

function getarch() {
  # get cpu architecture
  arch=$(lscpu | grep -w "Architecture" | sed -r 's/^.{33}//')
}

function arch() {
  # format cpu architecture
  getarch
  if [ "$arch" = "x86_64" ]; then
    arch_true=$arch
    arch="amd64"
  else
    arch_true=0
    arch=$arch
  fi
  # determine if i'm displaying arch_true or not
  if [ "$arch_true" = "0" ]; then
    archstring="$arch"
  else
    archstring="$arch ($arch_true)"
  fi
  echo "$archstring"
}

function getcache() {
  # get cpu cache information
  function getl1() {
    # get l1 cache info (l1i and l1d)
    l1instr_cache=$(lscpu | grep -w "L1i" | sed -r 's/^.{33}//')
    l1data_cache=$(lscpu | grep -w "L1d" | sed -r 's/^.{33}//')
  }
  l2_cache=$(lscpu | grep -w "L2" | sed -r 's/^.{33}//')
  l3_cache=$(lscpu | grep -w "L3" | sed -r 's/^.{33}//')
  getl1
}

function getextensions() {
  # get extensions (AVX, SSE)
  function getavx() {
    # get avx info
    if [ $(cat /proc/cpuinfo | grep -o "avx" | head -n 1) = "avx" ]; then
      # mark avx as present
      avx_present=1
    else
      avx_present=0
    fi
    # avx2
    if [ $(cat /proc/cpuinfo | grep -o "avx2" | head -n 1) = "avx2" ]; then
      avx2_present=1
    else
      avx2_present=0
    fi
    # now, format the avx info string
    if [ "$avx_present" = 1 ]; then
      # check if avx2 is present to add it
      if [ "$avx2_present" = 1 ]; then
        avx="AVX, AVX-2"
      else
        avx="AVX"
      fi
    else
      avx="None"
    fi
  }
  function getsse() {
    # get sse info
    if [ $(cat /proc/cpuinfo | grep -o "sse" | head -n 1) = "sse" ]; then
      sse_present=1
    else
      sse_present=0
    fi
    # sse2
    if [ $(cat /proc/cpuinfo | grep -o "sse2" | head -n 1) = "sse2" ]; then
      sse2_present=1
    else
      sse2_present=0
    fi
    # sse3
    if [ $(cat /proc/cpuinfo | grep -o "sse3" | head -n 1) = "sse3" ]; then
      sse3_present=1
    else
      sse3_present=0
    fi
    # 4
    if [ $(cat /proc/cpuinfo | grep -o "sse4" | head -n 1) = "sse4" ]; then
      sse4_present=1
    else
      sse4_present=0
    fi
    # now, format string
    if [ "$sse_present" = 1 ]; then
      # check if sse2 is available
      if [ "$sse2_present" = 1 ]; then
        sse="SSE, SSE-2"
      else
        sse="SSE"
      fi
      if [ "$sse3_present" = 1 ]; then
        sse="$sse, SSE-3"
      fi
      if [ "$sse4_present" = 1 ]; then
        sse="$sse, SSE-4"
      fi
    else
      sse="None"
    fi
  }
  getavx
  getsse
}

function cpudata() {
  # format the block, after running the functions
  if [ -f $HOME/.config/cpuinfo/config.conf ]; then
    # load user config
    source $HOME/.config/cpuinfo/config.conf
  fi
  echo "cpudata v0.0.0"
  # run the actual functions
  loadstyles
  getvendor
  getname
  getcpus
  getclocks
  getcache
  getextensions
  # formatting
  echo "--------------"
  echo "$(c1)Vendor:$(default) $vendor"
  echo "$(c1)Name:$(default) $cpuname"
  echo "$(c1)Architecture:$(default) $(arch)"
  echo "$(c1)No. of CPUs (physical):$(default) $cpus_p"
  echo "$(c1)No. of CPUs (logical):$(default) $cpus_l"
  echo "$(c1)Fastest Core Clock:$(default) $clock_fastest MHz"
  echo "$(c1)Slowest Core Clock:$(default) $clock_slowest MHz"
  echo "$(c1)L1d Cache:$(default) $l1data_cache"
  echo "$(c1)L1i Cache:$(default) $l1instr_cache"
  echo "$(c1)L2 Cache:$(default) $l2_cache"
  echo "$(c1)L3 Cache:$(default) $l3_cache"
  echo "$(c1)AVX:$(default) $avx"
  echo "$(c1)SSE:$(default) $sse"
}

function loadstyles() {
  # make it fancier
  function c1() {
    # defines the primary color
    if [ "$vendor" = "Advanced Micro Devices (AuthenticAMD)" ]; then
      tput setaf 196
    elif [ "$vendor" = "Intel Corporation (GenuineIntel)" ]; then
      tput setaf 14
    else
      tput sgr0
    fi
    # override brand styling if user defined a color
    if [ "$color" != "" ]; then
      tput setaf $color
    fi
  }
  function default() {
    # resets to default
    tput sgr0
  }
}

# finally execute
cpudata
if [ "$vendor" = "Unknown (Unknown)" ]; then
  # if couldn't find vendor then exit with fail state
  exit 1
else
  exit 0
fi
