package repository;
import model.IGeometricForm;
import repository.IRepo;
import exceptions.RepoException;

public class Repo implements IRepo
{
    protected IGeometricForm[] allGF;
    protected int length;
    public final static int SIZE = 10;

    public Repo()
    {
        this.allGF = new IGeometricForm[SIZE];
        length = 0;
    }
    @Override
    public void add(IGeometricForm igf) throws RepoException {
        if(length > SIZE)
            throw new RepoException("You can't add anymore items.The list is full\n");
        allGF[length++] = igf;
    }

    @Override
    public IGeometricForm[] getAll()
    {
        return this.allGF;
    }

    @Override
    public int getLength()
    {
        return this.length;
    }

}
