/** \file  queryexpansion.h
 *  \brief Header file for query expansion.
 */
 /*
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
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
 */

#ifndef XAPIAN_INCLUDED_QUERYEXPANSION_H
#define XAPIAN_INCLUDED_QUERYEXPANSION_H

#include <xapian/visibility.h>
#include <xapian.h>

#include <string>
#include <vector>

namespace Xapian {

class XAPIAN_VISIBILITY_DEFAULT AbstractQueryExpansion {
  protected:
	std::string original_query;
	std::vector<std::string> results;
  
  public:
	virtual std::string get_original_query() { };
	virtual std::vector<std::string> get_results() { };
};

class XAPIAN_VISIBILITY_DEFAULT SimpleQueryExpansion 
	: public AbstractQueryExpansion {
  public:
	SimpleQueryExpansion(std::string query) {
		original_query = query;
		// results.push_back(query);
	}

	std::string get_original_query() {
		return original_query;
	}

	std::vector<std::string> get_results() {
		return results;
	}
};

class XAPIAN_VISIBILITY_DEFAULT QueryExpansionDecorator 
	: public AbstractQueryExpansion {
  public:
	QueryExpansionDecorator() { }
	  /*QueryExpansionDecorator(AbstractQueryExpansion *obj) {
		original_query = obj->get_original_query();
		results = obj->get_results();
		expand();
	}
*/
	virtual void expand(){ };
	
	std::string get_original_query() {
		return original_query;
	}

	std::vector<std::string> get_results() {
		return results;
	}
};

}

#endif // XAPIAN_INCLUDED_QUERYEXPANSION_H
