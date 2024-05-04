//#include <cassert>
//#include <iostream>
//#include "Tests.h"
//#include "Service.h"
//
//using namespace std;
//
//void Tests::test_add() {
//    Service service;
//    service.addAdmin(Dog("shitzu", "Jessie",12, "ihwodi"));
//    service.addAdmin(Dog("lns", "asd",28, "dsfd"));
//    assert(service.getAdminRepo().getSize() == 2);
//    assert(service.getAdminRepo().findDog(Dog("ad", "asd", 12, "ds")) == -1);
//    assert(service.getAdminRepo().findDog(Dog("shitzu", "Jessie", 12, "ihwodi")) == 0);
//    bool result = service.addAdmin(Dog("ad", "asd", 12, "dsfd"));
//    assert(result == true);
//    result = service.addAdmin(Dog("shitzu", "Jessie", 12, "ihwodi"));
//    assert(result == false);
//    cout << ".test_add() passed!\n";
//
//}
//
//void Tests::test_remove() {
//    Service service;
//    service.addAdmin(Dog("ad", "asd",32, "dsfd"));
//    service.removeAdmin(Dog("a", "a", 0, "dsfd"));
//    assert(service.getAdminRepo().getSize() == 1);
//    assert(service.removeAdmin(Dog("a", "a", 0, "dsfd")) == false);
//    assert(service.getAdminRepo().getSize() == 1);
//    assert(service.getAdminRepo().removeAdmin(Dog("ad", "asd", 32, "dsfd")) == true);
//    cout << ".test_remove() passed!\n";
//}
//
//void Tests::test_update() {
//    Service service ;
//    service.addAdmin(Dog("ad", "asd", 32, "dsfd"));
//    service.updateAdmin(Dog("a", "a",0, "dsfd"), Dog("a", "a", 0, "dsfd"));
//    assert(service.getAdminRepo().getDogs().getElement(0).getBreed() == "ad");
//    assert(service.getAdminRepo().getDogs().getElement(0).getName() == "asd");
//    assert(service.getAdminRepo().getDogs().getElement(0).getAge() == 32);
//    assert(service.getAdminRepo().getDogs().getElement(0).getPhotograph() == "dsfd");
//    bool result = service.updateAdmin(Dog("a", "a", 0, "a"), Dog("a", "a", 0, "a"));
//    assert(result == 0);
//    result = service.getAdminRepo().updateAdmin(Dog("ad", "asd", 32, "dsfd"), Dog("a", "a", 0, "a"));
//    assert(result == true);
//    cout << ".test_update() passed!\n";
//}
//
//
//void Tests::test_dog_operator() {
//    Dog dog1 = Dog("a", "b",10, "sad");
//    dog1 = dog1;
//    assert(dog1 == dog1);
//    Dog dog2 = Dog("Labrador", "Buddy", 3, "labrador.jpg");
//    cout << ".test_dog_operator() passed!\n";
//    
//}
//
//void Tests::test_dynamic_array() {
//    DynamicArray<Dog> arr = DynamicArray<Dog>(2);
//    arr.addElement(Dog("a", "b", 10, "c"));
//    arr.addElement(Dog("d", "e",11, "f"));
//    arr.addElement(Dog("g", "h", 12, "i"));
//
//    DynamicArray<Dog> new_arr = DynamicArray<Dog>(arr);
//    new_arr = arr;
//    arr = arr;
//    assert(arr.getSize() == 3);
//    assert(new_arr.getSize() == 3);
//
//    arr.removeElement(0);
//    assert(arr.getSize() == 2);
//
//    arr.updateElement(0,Dog("i" , "j" , 13 , "k"));
//    assert(arr.getElement(0).getBreed() == "i");
//
//
//    cout << ".test_dynamic_array() passed!\n";
//}
//
//void Tests::test_add_user()
//{
//    Service serv;
//    serv.generate();
//    assert(serv.getUserRepo().getSize() == 0);
//    Dog dog1 = Dog("Shitzu", "Jessie", 17, "https://www.akc.org/2017/11/Shih-Tzu-On-White-01.jpg");
//    bool result = serv.addUser(dog1);
//    assert(serv.getUserRepo().getSize() == 1);
//    assert(serv.getUserRepo().addUser(Dog("Shitzu", "Jessie", 17, "https://www.akc.org/2017/11/Shih-Tzu-On-White-01.jpg")) == false);
//    assert(serv.getUserRepo().getAdoptedDogs().getSize() == 1);
//    assert(serv.getUserRepo().findAdoptedDog(Dog("Shitzu", "Jessie", 17, "https://www.akc.org/2017/11/Shih-Tzu-On-White-0.jpg")) == 0);
//    cout << ".test_add_user() passed!\n";
//}
//
//
//void Tests::testService()
//{
//    Service serv;
//    serv.generate();
//    assert(serv.getAdminRepo().getSize() == 10);
//    assert(Dog("Shitzu", "Jessie", 17, "https://www.akc.org/2017/11/Shih-Tzu-On-White-01.jpg") == serv.getAdminRepo().getDogs().getElement(0));
//    cout << ".test_service() passed!\n";
//}
//
//void Tests::test_all() {
//    test_add();
//    test_remove();
//    test_update();
//    test_dog_operator();
//    test_dynamic_array();
//    testService();
//    test_add_user();
//
//    cout << "All tests passed!\n";
//}