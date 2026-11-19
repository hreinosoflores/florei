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

import com.florei.api.model.SubCategoria;
import com.florei.api.repo.SubCategoriaRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/subcategoria")
@CrossOrigin
public class SubCategoriaController {

	@Autowired
	private SubCategoriaRepository subCategoriaRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, subCategoriaRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody SubCategoria subCategoria) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			subCategoria.setSlug(Global.toSlug(subCategoria.getDescripcion()));
			subCategoria.getAuditoria().setActivo(true);
			subCategoria.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, subCategoriaRepository.save(subCategoria));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody SubCategoria subCategoria) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			subCategoria.setSlug(Global.toSlug(subCategoria.getDescripcion()));
			subCategoria.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, subCategoriaRepository.save(subCategoria));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			subCategoriaRepository.deleteById(id);
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
			SubCategoria subCategoria = subCategoriaRepository.findById(id).orElse(null);
			if (subCategoria != null) {
				subCategoria.getAuditoria().setActivo(!subCategoria.getAuditoria().getActivo());
				subCategoria.getAuditoria().setFechaModificacion(new Date());
				subCategoria.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, subCategoriaRepository.save(subCategoria));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
