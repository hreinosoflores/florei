package com.florei.api.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.florei.api.model.Producto;
import com.florei.api.repo.ProductoRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/producto")
@CrossOrigin
public class ProductoController {

	@Autowired
	private ProductoRepository productoRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, productoRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody Producto producto) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			producto.getAuditoria().setActivo(true);
			producto.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, productoRepository.save(producto));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody Producto producto) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			producto.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, productoRepository.save(producto));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			productoRepository.deleteById(id);
			Global.resultOK(result, id);
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PatchMapping("/activo/{usu}/{id}")
	public Map<String, Object> toggleActivo(@PathVariable Long usu, @PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Producto producto = productoRepository.findById(id).orElse(null);
			if (producto != null) {
				producto.getAuditoria().setActivo(!producto.getAuditoria().getActivo());
				producto.getAuditoria().setFechaModificacion(new Date());
				producto.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, productoRepository.save(producto));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
