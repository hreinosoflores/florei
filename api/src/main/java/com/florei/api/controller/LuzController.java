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

import com.florei.api.model.Luz;
import com.florei.api.repo.LuzRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/luz")
@CrossOrigin
public class LuzController {

	@Autowired
	private LuzRepository luzRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, luzRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody Luz luz) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			luz.getAuditoria().setActivo(true);
			luz.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, luzRepository.save(luz));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody Luz luz) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			luz.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, luzRepository.save(luz));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			luzRepository.deleteById(id);
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
			Luz luz = luzRepository.findById(id).orElse(null);
			if (luz != null) {
				luz.getAuditoria().setActivo(!luz.getAuditoria().getActivo());
				luz.getAuditoria().setFechaModificacion(new Date());
				luz.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, luzRepository.save(luz));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
