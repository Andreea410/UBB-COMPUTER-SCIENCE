package exceptions;

import java.io.IOException;

public class RepoException extends RuntimeException {
    public RepoException(String message) {
        super(message);
    }
}
