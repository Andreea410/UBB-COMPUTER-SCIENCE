package model;
import model.IGeometricForm;

public class Sphere implements IGeometricForm
{
    protected double volume;

    public Sphere(double v)
    {
        this.volume = v;
    }

    @Override
    public double getVolume()
    {
        return this.volume;
    }

    @Override
    public void setVolume(double v)
    {
        this.volume = v;
    }

    public String toString()
    {
        return "Sphere with volume " + this.volume;
    }

}
