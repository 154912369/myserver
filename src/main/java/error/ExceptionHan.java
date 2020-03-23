package error;
import back.ResultMap;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;
import org.wf.jwtp.exception.ErrorTokenException;


@ControllerAdvice
class ExceptionHad{
    @ExceptionHandler(ErrorTokenException.class)
    public ModelAndView errorHandler(Exception ex) {
        ResultMap map=ResultMap.error(401,"验证失败或其他");
        return new ModelAndView(new MappingJackson2JsonView(), map);

    }
}
