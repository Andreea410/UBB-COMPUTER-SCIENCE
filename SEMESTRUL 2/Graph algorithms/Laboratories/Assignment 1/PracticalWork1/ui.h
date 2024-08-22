#pragma once
#ifndef FILE_REPOSITORY_H
#define FILE_REPOSITORY_H

#include <unordered_map>
#include <vector>
#include <stdexcept>
#include <utility> // for std::pair
#include <functional> // for std::hash
using namespace std;

struct pair_hash {
    template <class T1, class T2>
    std::size_t operator () (const std::pair<T1, T2>& pair) const {
        auto hash1 = std::hash<T1>{}(pair.first);
        auto hash2 = std::hash<T2>{}(pair.second);
        return hash1 ^ hash2;
    }
};

class FileRepository {
private:
    std::unordered_map<int ,std::pair<int, int>> dictCost;
    std::unordered_map<int, std::vector<int>> dictOut;
    std::unordered_map<int, std::vector<int>> dictIn;

public:
    void add_edge(int start, int end, int cost);

    void remove_edge(int start, int end);

    void add_vertex(int id);

    void remove_vertex(int id);

    void modify_cost(int start, int end, int new_cost);

    int retrieve_cost(int start, int end);

    std::unordered_map<int, std::pair<int, int>> get_dictCost();

    std::unordered_map<int, std::vector<int>> get_dictOut();

    std::unordered_map<int, std::vector<int>> get_dictIn();

    int get_number_of_vertices();

    int get_number_of_edges();

    int get_out_degree(int vertex);

    int get_in_degree(int vertex);

    std::vector<int> parse_outbound_edges(int vertex);

    std::vector<int> parse_inbound_edges(int vertex);

    // Function to create a random graph (for demonstration purposes)
    static FileRepository create_random_graph();
};

#endif // FILE_REPOSITORY_H
