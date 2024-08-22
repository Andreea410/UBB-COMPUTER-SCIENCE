class Complex:
    def __init__(self, real_part, imaginary_part):
        """
        init class for complex numbers
        :param real_part:int
        :param imaginary_part:int
        """

        self.real_part = real_part
        self.imaginary_part = imaginary_part

    @property
    def dictionary(self):
        return {"real_part": self.real_part,
                "imaginary_part": self.imaginary_part}

    @property
    def get_real_part(self):
        return self.real_part

    @property
    def get_imaginary_part(self):
        return self.imaginary_part
