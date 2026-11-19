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

import com.florei.api.model.Categoria;
import com.florei.api.repo.CategoriaRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/categoria")
@CrossOrigin
public class CategoriaController {

	@Autowired
	private CategoriaRepository categoriaRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, categoriaRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody Categoria categoria) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			categoria.setSlug(Global.toSlug(categoria.getDescripcion()));
			categoria.getAuditoria().setActivo(true);
			categoria.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, categoriaRepository.save(categoria));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody Categoria categoria) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			categoria.setSlug(Global.toSlug(categoria.getDescripcion()));
			categoria.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, categoriaRepository.save(categoria));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			categoriaRepository.deleteById(id);
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
			Categoria categoria = categoriaRepository.findById(id).orElse(null);
			if (categoria != null) {
				categoria.getAuditoria().setActivo(!categoria.getAuditoria().getActivo());
				categoria.getAuditoria().setFechaModificacion(new Date());
				categoria.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, categoriaRepository.save(categoria));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
