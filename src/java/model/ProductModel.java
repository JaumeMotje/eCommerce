package model;

import entity.Product;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.transaction.UserTransaction;

public class ProductModel {

    private UserTransaction utx;
    private EntityManager em;

    public ProductModel(EntityManager em, UserTransaction utx) {
        this.utx = utx;
        this.em = em;
    }

    public List<Product> retrieveByCategoryId(int categoryId) {
        Query q = em.createQuery("SELECT p FROM Product p WHERE p.category.id = :categoryId");
        q.setParameter("categoryId", categoryId);
        return q.getResultList();
    }

    public Product retrieveById(int productId) {
        return em.find(Product.class, productId);
    }
}
