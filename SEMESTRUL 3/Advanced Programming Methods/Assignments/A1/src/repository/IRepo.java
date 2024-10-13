package repository;

import exceptions.RepoException;
import model.IGeometricForm;

public interface IRepo {
    public void add(IGeometricForm g) throws RepoException;
    public IGeometricForm[] getAll();
    public int getLength();
}
