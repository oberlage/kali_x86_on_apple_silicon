FROM --platform=linux/amd64 kalilinux/kali-rolling
RUN apt -o "Acquire::https::Verify-Peer=false" update 
RUN apt -o "Acquire::https::Verify-Peer=false" install -y ca-certificates apt-transport-https
RUN apt install -y mingw-w64 nano file iputils-ping nmap man-db
CMD bash