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

import com.florei.api.model.Interruptor;
import com.florei.api.repo.InterruptorRepository;
import com.florei.api.util.Global;

@RestController
@RequestMapping(path = "/interruptor")
@CrossOrigin
public class InterruptorController {
	@Autowired
	private InterruptorRepository interruptorRepository;

	@GetMapping()
	public Map<String, Object> findAll() {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			Global.resultOK(result, interruptorRepository.findAll());
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PostMapping()
	public Map<String, Object> create(@RequestBody Interruptor interruptor) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			interruptor.getAuditoria().setActivo(true);
			interruptor.getAuditoria().setFechaCreacion(new Date());

			Global.resultOK(result, interruptorRepository.save(interruptor));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@PutMapping()
	public Map<String, Object> edit(@RequestBody Interruptor interruptor) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			interruptor.getAuditoria().setFechaModificacion(new Date());

			Global.resultOK(result, interruptorRepository.save(interruptor));
		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

	@DeleteMapping("/{id}")
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			interruptorRepository.deleteById(id);
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
			Interruptor interruptor = interruptorRepository.findById(id).orElse(null);
			if (interruptor != null) {
				interruptor.getAuditoria().setActivo(!interruptor.getAuditoria().getActivo());
				interruptor.getAuditoria().setFechaModificacion(new Date());
				interruptor.getAuditoria().setUsuarioModificacion(usu);
				Global.resultOK(result, interruptorRepository.save(interruptor));
			}

		} catch (Exception e) {
			Global.resultError(result, e);
		}
		return result;
	}

}
