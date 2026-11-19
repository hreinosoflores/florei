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

import com.florei.api.model.Imagen;
import com.florei.api.repo.ImagenRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/imagen")
@CrossOrigin
public class ImagenController {

	@Autowired
	private ImagenRepository imagenRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, imagenRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody Imagen imagen) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			imagen.getAuditoria().setActivo(true);
			imagen.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, imagenRepository.save(imagen));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody Imagen imagen) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			imagen.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, imagenRepository.save(imagen));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			imagenRepository.deleteById(id);
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
			Imagen imagen = imagenRepository.findById(id).orElse(null);
			if (imagen != null) {
				imagen.getAuditoria().setActivo(!imagen.getAuditoria().getActivo());
				imagen.getAuditoria().setFechaModificacion(new Date());
				imagen.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, imagenRepository.save(imagen));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
