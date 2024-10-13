package model;
import model.IGeometricForm;

public class Cylinder implements IGeometricForm{
    protected double volume;

    public Cylinder(double v)
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
        return "Cylinder with volume " + this.volume;
    }
}
