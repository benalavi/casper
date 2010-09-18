Casper
======

A DSL for automated mouse and keyboard input in X11.

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
