# Follow the steps to build the kernel
1) Run lfs.sh file to create partition table in a usb-stick/disk.(should be of ~30GB)
    -> Partition of 100mb is created for boot partition and rest is for root partition.
    -> The last part of lfs downloads all the packages present in packages.csv file and copies it to our /sources folder in the usb-stick.
    -> As time passes some package versions get obselete and may be removed from there website. They would throw an error in the terminal while          downloading. Hence find the correct version of the package and update the version (2nd column) in packages.csv file. Download the file manually
    and run ~$md5sum *package-name* to get the md5sum of the package. Update it in the packages.csv(last column) for proper verification while downloading