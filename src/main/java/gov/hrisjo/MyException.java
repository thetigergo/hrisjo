package hrisjo;

/**
 *
 * @author felix
 */
public class MyException extends java.lang.Exception {

    private static final long serialVersionUID = 1078828264809922297L;

  public MyException() {super();}
  public MyException(String message) {super(message);}
  public MyException(String message, Throwable cause) {super(message, cause);}
  public MyException(Throwable cause) {super(cause);}
  
}