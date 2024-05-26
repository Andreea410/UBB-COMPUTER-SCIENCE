//#include <cassert>
//#include <iostream>
//#include "Tests.h"
//#include "Service.h"
//
//using namespace std;
//
//void Tests::test_add() {
//    Service service;
//    service.addAdmin(Dog("shitzu", "Jessie", 12, "ihwodi" , false));
//    service.addAdmin(Dog("lns", "asd", 28, "dsfd", false));
//    assert(service.getRepo().getSize() == 2);
//    assert(service.getRepo().findDog(Dog("ad", "asd", 12, "ds", false)) == -1);
//    assert(service.getRepo().findDog(Dog("shitzu", "Jessie", 12, "ihwodi", false)) == 0);
//    bool result = service.addAdmin(Dog("ad", "asd", 12, "dsfd" , false));
//    assert(result == true);
//    result = service.addAdmin(Dog("shitzu", "Jessie", 12, "ihwodi", false));
//    assert(result == false);
//    cout << ".test_add() passed!\n";
//
//}
//
//void Tests::test_remove() {
//    Service service;
//    service.addAdmin(Dog("ad", "asd", 32, "dsfd", false));
//    service.removeAdmin(Dog("a", "a", 0, "dsfd", false));
//    assert(service.getRepo().getSize() == 1);
//    assert(service.removeAdmin(Dog("a", "a", 0, "dsfd", false)) == false);
//    assert(service.getRepo().getSize() == 1);
//    assert(service.getRepo().removeAdmin(Dog("ad", "asd", 32, "dsfd", false)) == true);
//    cout << ".test_remove() passed!\n";
//}
//
//void Tests::test_update() {
//    Service service;
//    service.addAdmin(Dog("ad", "asd", 32, "dsfd", false));
//    service.updateAdmin(Dog("a", "a", 0, "dsfd", false), Dog("a", "a", 0, "dsfd", false));
//    assert(service.getRepo().getDogs().at(0).getBreed() == "ad");
//    assert(service.getRepo().getDogs().at(0).getName() == "asd");
//    assert(service.getRepo().getDogs().at(0).getAge() == 32);
//    assert(service.getRepo().getDogs().at(0).getPhotograph() == "dsfd");
//    bool result = service.updateAdmin(Dog("a", "a", 0, "a", false), Dog("a", "a", 0, "a", false));
//    assert(result == 0);
//    result = service.getRepo().updateAdmin(Dog("ad", "asd", 32, "dsfd", false), Dog("a", "a", 0, "a", false));
//    assert(result == true);
//    cout << ".test_update() passed!\n";
//}
//
//
//void Tests::test_dog_operator() {
//    Dog dog1 = Dog("a", "b", 10, "sad", false);
//    dog1 = dog1;
//    assert(dog1 == dog1);
//    Dog dog2 = Dog("Labrador", "Buddy", 3, "labrador.jpg", false);
//    cout << ".test_dog_operator() passed!\n";
//
//}
//
//void Tests::testService()
//{
//    Service serv;
//    serv.generate();
//    assert(serv.getRepo().getSize() == 10);
//    assert(Dog("Shitzu", "Jessie", 17, "https://www.akc.org/2017/11/Shih-Tzu-On-White-01.jpg", false) == serv.getRepo().getDogs().at(0));
//    cout << ".test_service() passed!\n";
//}
//
//void Tests::test_all() {
//    test_add();
//    test_remove();
//    test_update();
//    test_dog_operator();
//    testService();
//
//    cout << "All tests passed!\n";
//}