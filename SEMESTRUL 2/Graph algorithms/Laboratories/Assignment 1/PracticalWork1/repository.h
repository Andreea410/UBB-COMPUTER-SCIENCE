#pragma once
#ifndef DOUBLE_DICT_GRAPH_H
#define DOUBLE_DICT_GRAPH_H

#include <unordered_map>
#include <vector>
#include <stdexcept>

using namespace std;

class DoubleDictGraph {
private:
    std::unordered_map<int, std::vector<int>> _dictOut; // successors
    std::unordered_map<int, std::vector<int>> _dictIn;  // predecessors
    std::unordered_map<std::pair<int, int>, int> _dictCost;

public:
    DoubleDictGraph() = default;
    DoubleDictGraph& operator=(const DoubleDictGraph& other);
    DoubleDictGraph(int n);

    int get_number_of_vertices() const;
    int get_number_of_edges() const;

    std::vector<int> parse_noduri() const;

    bool is_edge(int start, int end) const;

    int get_in_degree(int nod) const;
    int get_out_degree(int nod) const;

    std::vector<int> parse_outbound_edges(int nod) const;
    std::vector<int> parse_inbound_edges(int nod) const;

    void add_edge(int start, int end, int cost);
    void remove_edge(int start, int end);

    void add_nod(int id);
    void remove_nod(int id);

    void retrieve_cost(int start, int end);
    void modify_cost(int start, int end, int newcost);

    std::unordered_map<int, std::vector<int>> get_dictIn() const;
    std::unordered_map<int, std::vector<int>> get_dictOut() const;
    std::unordered_map<std::pair<int, int>, int> get_dictCost() const;

    DoubleDictGraph get_graf() const;

    void printAll() const;
};

#endif // DOUBLE_DICT_GRAPH_H
