%{
/* xapian-headers.i: Getting SWIG to parse Xapian's C++ headers.
 *
 * Copyright 2006,2011 Olly Betts
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301
 * USA
 */
%}

%define STANDARD_IGNORES(NS, CLASS)
    %ignore NS::CLASS::internal;
    %ignore NS::CLASS::CLASS(Internal*);
    %ignore NS::CLASS::operator=;
%enddef

/* We use %ignore and %extend rather than %rename on operator* so that any
 * pattern rename used to match local naming conventions applies to
 * DEREF_METHOD.
 */
%define INPUT_ITERATOR_METHODS(NS, CLASS, RET_TYPE, DEREF_METHOD)
    STANDARD_IGNORES(NS, CLASS)
    %ignore NS::CLASS::operator++;
    %ignore NS::CLASS::operator*;
    %extend NS::CLASS {
        bool equals(const NS::CLASS & o) const { return *self == o; }
        RET_TYPE DEREF_METHOD() const { return **self; }
        NEXT(RET_TYPE, NS::CLASS)
    }
%enddef

/* Ignore these for all classes: */
%ignore operator==;
%ignore operator!=;
%ignore difference_type;
%ignore iterator_category;
%ignore value_type;

/* These methods won't throw exceptions. */
%exception Xapian::major_version "$action"
%exception Xapian::minor_version "$action"
%exception Xapian::revision "$action"
%exception Xapian::version_string "$action"
%include <xapian.h>

/* We don't wrap the version macros - they're useful for compile time checks
 * in C++ code, but for a scripting language, the version functions tell us
 * the version of Xapian we're actually using, which is more interesting than
 * the one the bindings were built against.
 */
/* %include <xapian/version.h> */

/* Types are needed by most of the other headers. */
%include <xapian/types.h>

/* The Error subclasses are handled separately for languages where we wrap
 * them. */
/* %include <xapian/error.h> */

/* ErrorHandler isn't currently wrapped. */
/* %include <xapian/errorhandler.h> */

/* Currently wrapped via declarations in xapian.i: */
/* %include <xapian/database.h> */

/* Currently wrapped via declarations in xapian.i: */
/* %include <xapian/dbfactory.h> */

INPUT_ITERATOR_METHODS(Xapian, PositionIterator, Xapian::termpos, get_termpos)
%include <xapian/positioniterator.h>

%ignore Xapian::DocIDWrapper;
INPUT_ITERATOR_METHODS(Xapian, PostingIterator, Xapian::docid, get_docid)
%include <xapian/postingiterator.h>

INPUT_ITERATOR_METHODS(Xapian, TermIterator, std::string, get_term)
%include <xapian/termiterator.h>

/* FIXME: Not all languages fully ignore ValueIteratorEnd_ */
#undef ValueIteratorEnd_
%ignore ValueIterator(const ValueIteratorEnd_ &);
%ignore operator=(const ValueIteratorEnd_ &);
%ignore operator==(const ValueIterator &, const ValueIteratorEnd_ &);
%ignore operator==(const ValueIteratorEnd_ &, const ValueIterator &);
%ignore operator==(const ValueIteratorEnd_ &, const ValueIteratorEnd_ &);
%ignore operator!=(const ValueIterator &, const ValueIteratorEnd_ &);
%ignore operator!=(const ValueIteratorEnd_ &, const ValueIterator &);
%ignore operator!=(const ValueIteratorEnd_ &, const ValueIteratorEnd_ &);
%ignore Xapian::ValueIteratorEnd_;
INPUT_ITERATOR_METHODS(Xapian, ValueIterator, std::string, get_value)
%include <xapian/valueiterator.h>
#define ValueIteratorEnd_ ValueIterator

STANDARD_IGNORES(Xapian, Document)
%include <xapian/document.h>

/* Currently wrapped by inclusion in xapian.i: */
/* %include <xapian/termgenerator.h> */

/* Currently wrapped via declarations in xapian.i: */
/* %include <xapian/enquire.h> */

/* Currently wrapped via declarations in xapian.i: */
/* %include <xapian/expanddecider.h> */

/* Currently wrapped by inclusion in xapian.i: */
/* %include <xapian/keymaker.h> */

/* Currently wrapped by inclusion in xapian.i: */
/* %include <xapian/matchspy.h> */

/* Currently wrapped by inclusion in xapian.i: */
/* %include <xapian/postingsource.h> */

/* Currently wrapped by inclusion in xapian.i: */
/* %include <xapian/query.h> */

/* Currently wrapped by inclusion in xapian.i: */
/* %include <xapian/queryparser.h> */

/* Currently wrapped by inclusion in xapian.i: */
/* %include <xapian/valuesetmatchdecider.h> */

/* Currently wrapped by inclusion in xapian.i: */
/* %include <xapian/weight.h> */

/* Currently wrapped by inclusion in xapian.i: */
/* %include <xapian/stem.h> */

/* Currently wrapped by inclusion in xapian.i: */
/* %include <xapian/registry.h> */

/* We don't wrap Xapian's Unicode support as other languages usually already
 * have their own Unicode support. */
/* %include <xapian/unicode.h> */

/* Currently wrapped by inclusion in xapian.i: */
/* %include <xapian/compactor.h> */