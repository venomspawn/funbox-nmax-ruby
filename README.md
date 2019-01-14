[![Build Status](https://travis-ci.com/venomspawn/funbox-nmax-ruby.svg?branch=develop)](https://travis-ci.com/venomspawn/funbox-nmax-ruby)

# Solution to `nmax` test problem

The project contains solution to `nmax` test problem from [FunBox's test
case](https://dl.funbox.ru/qt-ruby.pdf) written on Ruby.

## Usage

### Provisioning and initial setup

Although it's not required, it's highly recommended to use the project in a
virtual machine. The project provides `Vagrantfile` to automatically deploy and
provision virtual machine with use of [VirtualBox](https://www.virtualbox.org/)
and [vagrant](https://www.vagrantup.com/) tool. One can use `vagrant up` in the
root directory of the cloned project to launch virtual machine and `vagrant
ssh` to enter it after boot. The following commands should be of use in the
terminal of virtual machine:

*   `bundle install` — install libraries used by the project to debug and test
    runs;
*   `make debug` — launch debug console application;
*   `make test` — run tests.

### Building

The solution can be packed into Ruby library as it's required by the problem.
This can be achieved via invoking of `make build` command. After the invocation
a file with `nmax-<VERSION>.gem` would appear. Here `<VERSION>` means a string
with the release version.

### Installation

The result of building can be installed as any regular `gem`-file with
`gem install` command.

### Invocation

After the installation mentioned above, `nmax` command can be invoked. The
command supports one optional argument with amount of kept numbers. If the
argument is absent or not a strictly positive number, default `100` value is
used. Example of invocation:

```
cat your_40GB_file | nmax 10000
```

## Documentation

The project uses in-code documentation in [`yard`](https://yardoc.org) format.
One can invoke `make doc` command to translate the documentation to HTML (it
will appear in `doc` directory in the project).

## Additional comments

One would be interested, perhaps, in another solution to the same problem,
namely the [C one](https://github.com/venomspawn/funbox-nmax-c).
