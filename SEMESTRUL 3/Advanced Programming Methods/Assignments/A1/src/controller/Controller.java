package controller;
import exceptions.RepoException;
import model.IGeometricForm;
import repository.IRepo;
import repository.Repo;

public class Controller
{
    IRepo repo;

    public Controller(IRepo r)
    {
        this.repo = r;
    }

    public IRepo getRepo()
    {
        return this.repo;
    }

    public IGeometricForm[] filteredList(double volume)
    {
        IGeometricForm[] all = this.repo.getAll();
        IGeometricForm[] filteredList = new IGeometricForm[Repo.SIZE];
        int j = 0;
        if(repo.getLength() == 0)
            return null;
        for(int i = 0;i < repo.getLength();i++)
        {
            if(all[i].getVolume() <= volume)
            {
                filteredList[j] = all[i];
                j++;
            }
        }
        return filteredList;
    }

    public void add(IGeometricForm f) throws RepoException
    {
        repo.add(f);
    }





}
