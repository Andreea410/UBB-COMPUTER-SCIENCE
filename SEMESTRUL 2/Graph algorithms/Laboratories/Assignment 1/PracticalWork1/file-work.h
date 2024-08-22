#ifndef FILE_GRAPHS_H
#define FILE_GRAPHS_H

#include "repository.h"
#include <string>
#include <vector>
#include <tuple>

using namespace std;

class FileGraphs {
private:
    DoubleDictGraph _graph;
    std::string _fileName;
    std::vector<std::tuple<int, int, int>> _entities;

    void readFile();
    void writeAllToFile();

public:
    FileGraphs(const std::string& filename);

    void createGraph();
    void updateEntities();

    void addEdge(int start, int end, int cost);
    void removeEdge(int start, int end);
    void addVertex(int id);
    void removeVertex(int id);
    void retrieveCost(int start, int end);
    void modifyCost(int start, int end, int new_cost);

    std::vector<std::tuple<int, int, int>> getAll() const;
    DoubleDictGraph getGraph() const;
    std::unordered_map<int, std::vector<int>> getDictOut() const;
    std::unordered_map<int, std::vector<int>> getDictIn() const;
    std::unordered_map<std::pair<int, int>, int> getDictCost() const;
    int getNumberOfVertices() const;
    int getNumberOfEdges() const;
    int getInDegree(int vertex) const;
    int getOutDegree(int vertex) const;
    std::vector<int> parseOutboundEdges(int vertex) const;
    std::vector<int> parseInboundEdges(int vertex) const;
};

void addEdgeInRandomGraph(int numberOfVertices, DoubleDictGraph& graph);
DoubleDictGraph createRandomGraph();

#endif // FILE_GRAPHS_H
