package model;
import model.IGeometricForm;

public class Cube implements IGeometricForm
{
    protected double volume;

    public Cube(double v)
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
        return "Cube with volume " + this.volume;
    }
}
