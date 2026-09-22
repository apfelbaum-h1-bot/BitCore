// Compatibility shim for Boost >= 1.73:
// unqualified placeholders (_1, _2, ...) were removed from boost/bind headers.
// Force-included via CXXFLAGS -include for the whole build.
#ifndef BOOST_PLACEHOLDERS_COMPAT_H
#define BOOST_PLACEHOLDERS_COMPAT_H
#include <boost/bind/placeholders.hpp>
#include <deque>
using namespace boost::placeholders;
#endif
