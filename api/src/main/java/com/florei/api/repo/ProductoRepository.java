package com.florei.api.repo;

import org.springframework.data.repository.CrudRepository;

import com.florei.api.model.Producto;

public interface ProductoRepository extends CrudRepository<Producto, Long> {

}
