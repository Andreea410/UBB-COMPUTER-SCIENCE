#include "repository.h"
#include <fstream>
#include <iostream>
#include <cstdlib> // for rand() and srand()
#include <ctime> // for time()

using namespace std;

class FileGraphs {
private:
    DoubleDictGraph _graph;
    std::string _fileName;
    std::vector<std::tuple<int, int, int>> _entities;

    void readFile() {
        _entities.clear();
        std::ifstream file(_fileName);
        if (!file.is_open()) {
            throw std::runtime_error("File not found!");
        }

        int vertices, edges;
        file >> vertices >> edges;
        _entities.emplace_back(vertices, edges, 0);

        for (int i = 0; i < edges; ++i) {
            int start, end, cost;
            file >> start >> end >> cost;
            _entities.emplace_back(start, end, cost);
        }

        file.close();
    }

    void writeAllToFile() {
        std::ofstream file(_fileName);
        if (!file.is_open()) {
            throw std::runtime_error("File not found!");
        }

        file << std::get<0>(_entities[0]) << " " << std::get<1>(_entities[0]) << std::endl;
        for (size_t i = 1; i < _entities.size(); ++i) {
            file << std::get<0>(_entities[i]) << " " << std::get<1>(_entities[i]) << " " << std::get<2>(_entities[i]) << std::endl;
        }

        file.close();
    }

public:
    FileGraphs(const std::string& filename) : _fileName(filename) {
        readFile();
        createGraph();
    }

    void createGraph() {
        _graph = DoubleDictGraph(std::get<0>(_entities[0]));
        for (size_t i = 1; i < _entities.size(); ++i) {
            int start = std::get<0>(_entities[i]);
            int end = std::get<1>(_entities[i]);
            int cost = std::get<2>(_entities[i]);
            _graph.add_edge(start, end, cost);
        }
    }

    void updateEntities() {
        auto dictionary_of_costs = _graph.get_dictCost();
        auto number_of_vertices = _graph.get_number_of_vertices();
        _entities.clear();
        _entities.emplace_back(number_of_vertices, dictionary_of_costs.size(), 0);
        for (const auto& [key, value] : dictionary_of_costs) {
            _entities.emplace_back(key.first, key.second, value);
        }
    }

    void addEdge(int start, int end, int cost) {
        _graph.add_edge(start, end, cost);
        updateEntities();
        writeAllToFile();
    }

    void removeEdge(int start, int end) {
        _graph.remove_edge(start, end);
        updateEntities();
        writeAllToFile();
    }

    void addVertex(int id) {
        _graph.add_nod(id);
        updateEntities();
        writeAllToFile();
    }

    void removeVertex(int id) {
        _graph.remove_nod(id);
        updateEntities();
        writeAllToFile();
    }

    void retrieveCost(int start, int end) {
        _graph.retrieve_cost(start, end);
        updateEntities();
        writeAllToFile();
    }

    void modifyCost(int start, int end, int new_cost) {
        _graph.modify_cost(start, end, new_cost);
        updateEntities();
        writeAllToFile();
    }

    std::vector<std::tuple<int, int, int>> getAll() const {
        return _entities;
    }

    DoubleDictGraph getGraph() const {
        return _graph;
    }

    std::unordered_map<int, std::vector<int>> getDictOut() const {
        return _graph.get_dictOut();
    }

    std::unordered_map<int, std::vector<int>> getDictIn() const {
        return _graph.get_dictIn();
    }

    std::unordered_map<std::pair<int, int>, int> getDictCost() const {
        return _graph.get_dictCost();
    }

    int getNumberOfVertices() const {
        return _graph.get_number_of_vertices();
    }

    int getNumberOfEdges() const {
        return _graph.get_number_of_edges();
    }

    int getInDegree(int vertex) const {
        return _graph.get_in_degree(vertex);
    }

    int getOutDegree(int vertex) const {
        return _graph.get_out_degree(vertex);
    }

    std::vector<int> parseOutboundEdges(int vertex) const {
        return _graph.parse_outbound_edges(vertex);
    }

    std::vector<int> parseInboundEdges(int vertex) const {
        return _graph.parse_inbound_edges(vertex);
    }
};

void addEdgeInRandomGraph(int numberOfVertices, DoubleDictGraph& graph) {
    srand(time(nullptr)); // Seed the random number generator
    int start = rand() % numberOfVertices;
    int end = rand() % numberOfVertices;
    int cost = rand() % 100 + 1; // Random cost between 1 and 100
    if (!graph.is_edge(start, end)) {
        graph.add_edge(start, end, cost);
    }
}

DoubleDictGraph createRandomGraph() {
    srand(time(nullptr)); // Seed the random number generator
    int numberOfVertices = rand() % 10 + 1; // Random number of vertices between 1 and 10
    int numberOfEdges = rand() % 37 + 4; // Random number of edges between 4 and 40

    DoubleDictGraph randomGraph(numberOfVertices);
    for (int i = 0; i < numberOfEdges; ++i) {
        addEdgeInRandomGraph(numberOfVertices, randomGraph);
    }

    return randomGraph;
}
