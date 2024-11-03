package web.action;

import javax.servlet.http.*;
import model.CategoryModel;
import model.ProductModel;
import web.ViewManager;

public class categoryAction implements Action {

    private CategoryModel categoryModel;
    private ProductModel productModel;

    public categoryAction(CategoryModel categoryModel, ProductModel productModel) {
        this.categoryModel = categoryModel;
        this.productModel = productModel;
    }

    @Override
    public void perform(HttpServletRequest req, HttpServletResponse resp) {
        String categoryId = req.getParameter("categoryid");

        if (categoryId != null) {
            try {
                int catId = Integer.parseInt(categoryId);
                req.setAttribute("products", productModel.retrieveByCategoryId(catId));
                req.setAttribute("categoryName", categoryModel.getCategoryNameById(catId));
                req.setAttribute("categories", categoryModel.retrieveAll());
                ViewManager.nextView(req, resp, "/view/category.jsp");
            } catch (NumberFormatException e) {
                System.out.println("Invalid category ID format: " + e.getMessage());
                ViewManager.nextView(req, resp, "/error.jsp");
            }
        } else {
            // If categoryId is not provided, show an error or redirect
            ViewManager.nextView(req, resp, "/error.jsp");
        }
    }
}
