# Filename: donightlytests.sh
# Author:   LIU Yang
# Create Time: Fri Nov  8 21:40:31 HKT 2013
# License:     LGPL v2.0+
# Contact Me:  JeremyRobturtle@gmail.com
# Brief: Do CDash nightly tests at $script_root
export DISPLAY=:0.0
script_root="$HOME/CDashTests"
cd "$script_root"
for s in $(ls *.cmake); do
    echo "Test for $s"
    ctest -S "$s"
done
