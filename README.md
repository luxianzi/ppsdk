Pompano SDK
===========

Pompano is an industrial automation controller running real-time Linux. We could use the SDK to
develop any application or Pompano BSP. The SDK is based on Ubuntu 20.04 docker image, and including
the following packages:

   ```
   gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat cpio
   libncurses5-dev tree xz-utils debianutils iputils-ping g++-multilib cmake vim u-boot-tools
   ```

And also includeing:

   ```
   Linaro ARM GCC 4.9-2016.02 (Hard Float)
   Pompano Development Sysroot
   ```

1. Setting up

   ```
   ./init_sdk.sh
   ```

   The script will ask for rebooting before the initialization is properly done.

2. Copy files to the `share` directory

3. Start the docker container

   ```
   ./run_docker.sh
   ```

4. Usage

   E.g. we cloned this repo to `/home/<user>/ppsdk`, and put the Linux kernel to
   `/home/<user>/ppsdk/share/linux-x.y.z`, we just need to run:

   ```
   <user>@<host>$ cd /home/<user>/ppsdk
   <user>@<host>$ ./run_docker.sh
   builder@<container>$ cd ~/share/linux-x.y.z
   builder@<container>$ make ARCH=arm menuconfig
   builder@<container>$ make ARCH=arm -j<thread_number>
   builder@<container>$ make ARCH=arm uImage
   ```
   
   Then you should be able to put the `arch/arm/boot/uImage` to a directory on which a TFTP server
   is running, then download the uImage using u-boot on Pompano.

   E.g. we cloned this repo to `/home/<user>/ppsdk`, and created a CMake project in
   `/home/<user>/ppsdk/share/hello_world`, we would like to build and run the hello_world binary on
   Pompano, we just need to run:

   ```
   <user>@<host>$ ssh root@<Pompano IP>
   ...Some prompt about keys, type yes...
   # mount -o remount,rw /
   # exit
   <user>@<host>$ cd /home/<user>/ppsdk
   <user>@<host>$ ./run_docker.sh
   builder@<container>$ cd ~/share/hello_world
   builder@<container>$ cmake .
   builder@<container>$ make -j<thread_number>
   builder@<container>$ scp hello_world root@<Pompano IP>:/home/default
   builder@<container>$ ssh root@<Pompano IP>
   # cd /home/default
   # ./hello_world
   ```

Note:

   * The container of the SDK will be destroyed every time when you exit the `builder@<container>$`
     shell. Everything outside the `share` directory will be lost.

   * Please refer to docker documents about how to check and manange images and containers.

Enjoy!

