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

import com.florei.api.model.GuiaDeRemision;
import com.florei.api.repo.GuiaDeRemisionRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/guiaderemision")
@CrossOrigin
public class GuiaDeRemisionController {

	@Autowired
	private GuiaDeRemisionRepository guiaDeRemisionRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, guiaDeRemisionRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody GuiaDeRemision guiaDeRemision) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			guiaDeRemision.getAuditoria().setActivo(true);
			guiaDeRemision.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, guiaDeRemisionRepository.save(guiaDeRemision));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody GuiaDeRemision guiaDeRemision) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			guiaDeRemision.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, guiaDeRemisionRepository.save(guiaDeRemision));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			guiaDeRemisionRepository.deleteById(id);
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
			GuiaDeRemision guiaDeRemision = guiaDeRemisionRepository.findById(id).orElse(null);
			if (guiaDeRemision != null) {
				guiaDeRemision.getAuditoria().setActivo(!guiaDeRemision.getAuditoria().getActivo());
				guiaDeRemision.getAuditoria().setFechaModificacion(new Date());
				guiaDeRemision.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, guiaDeRemisionRepository.save(guiaDeRemision));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
