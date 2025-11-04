public class MatrixMultiplier {

    public static double computeElement(double[][] A, double[][] B, int row, int col) {
        double sum = 0;
        for (int k = 0; k < A[0].length; k++) {
            sum += A[row][k] * B[k][col];
        }
        return sum;
    }

    public static double[][] generateMatrix(int rows, int cols) {
        double[][] m = new double[rows][cols];
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                m[i][j] = Math.random() * 10;
            }
        }
        return m;
    }
}
