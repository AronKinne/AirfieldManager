// https://forum.processing.org/two/discussion/13093/how-to-call-function-by-string-content

import java.lang.reflect.Method;

public static class MethodRelay {
 
  /** The object to handle the draw event */
  private Object handlerObject = null;
  /** The method in drawHandlerObject to execute */
  private Method handlerMethod = null;
  /** the name of the method to handle the event */
  private String handlerMethodName;
  /** An array of classes that represent the function
   parameters in order */
  private Class[] parameters = null;
 
  /**
   Register a method that has parameters.
   parameter obj the object that contains the method to invoke
   parameter name the name of the method
   parameter args a comma separated list of  
   */
  MethodRelay(Object obj, String name, Class... args) {
    try {
      handlerMethodName = name;
      parameters = args;
      handlerMethod = obj.getClass().getMethod(handlerMethodName, parameters);
      handlerObject = obj;
    } 
    catch (Exception e) {
      println("Unable to find the function -");
      print(handlerMethodName + "( ");
      if (parameters != null) {
        for (Class c : parameters)
          print(c.getSimpleName() + " ");
        println(")");
      }
    }
  }
 
  /**
   Register a method that has no parameters.
   parameter obj the object that contains the method to invoke
   parameter name the name of the method
   */
  MethodRelay(Object obj, String name) {
    this(obj, name, (Class[])null);
  }
 
  /**
   Execute a paramerterless method
   */
  void execute() {
    execute((Object[])null);
  }
 
  /**
   Execute a method with parameters
   parameter data a comma separated list of values 
   to be passed to the method
   */
  void execute(Object... data) {
    if (handlerObject != null) {
      try {
        handlerMethod.invoke(handlerObject, data);
      } 
      catch (Exception e) {
        println("Error on invoke");
      }
    }
  }
}
