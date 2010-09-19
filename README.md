Casper
======

A DSL for automated mouse <del>and keyboard</del> input in X11.

Usage
-----

Right now Casper only does mouse input, it looks something like this:

    Casper::Mouse.move 200, 300 # puts the cursor at x: 200px, y: 300px
    Casper::Mouse.down          # presses the primary mouse button
    Casper::Mouse.up            # releases the primary mouse button
    Casper::Mouse.click         # clicks with the primary mouse button
    Casper::Mouse.location      # => [ 200, 300 ]

Which is all well and good, but the more useful stuff looks like:

    Casper::Mouse.drag :from => [ 200, 300 ], :distance => [ 30, 60 ], :increments => 10 do
      Casper::Mouse.drag :distance => [ 80, 100 ] do
        sleep 0.5
      end
    end
    
We've found it particularly useful in conjunction with Selenium-based
Javascript testing. We use it reliably test complex movements (such as a
velocity-aware drag, or drag and drop between multiple containers with
timeouts, etc...)

Requirements
------------

Requires `libxdo` (comes with `xdotool`). Details and installation
instructions can be found at http://www.semicomplete.com/projects/xdotool/.

Quick build instructions for Ubuntu (tested on 10.04):

    $ sudo apt-get install xorg-dev
    $ wget http://semicomplete.googlecode.com/files/xdotool-2.20100818.3004.tar.gz
    $ tar xzvf xdotool-2.20100818.3004.tar.gz
    $ cd xdotool-2.20100818.3004
    $ sudo make all install

Testing
-------

We test Casper in a VM environment set up by Vagrant. If you have Vagrant
(http://www.vagrantup.com/) set up and running, and you have the lucid32.box,
you can just do:

    $ cd test && vagrant up

Once your VM is provisioned and running, ssh in (`vagrant ssh`) and then:

    $ startx &
    $ cd ~/casper/test
    $ ruby casper_test.rb

If you don't have Vagrant set up, you can follow the getting started guide at
http://www.vagrantup.com/, or you can install the necessary dependencies on
your local machine and test locally. Instructions for installing the
dependencies can be found under `test/cookbooks`.

License
-------

Copyright (c) 2010 Ben Alavi and Chris Schneider

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
