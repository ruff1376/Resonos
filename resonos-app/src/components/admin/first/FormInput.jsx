import React from 'react';

const FormInput = ({
  label,
  name,
  type = 'text',
  value,
  onChange,
  required = false,
  className = 'form-control',
  containerClassName = 'col-md-6 text-start',
  ...rest
}) => {
  return (
    <div className={containerClassName}>
      <label className="form-label" htmlFor={name}>
        {label}
      </label>
      <input
        id={name}
        name={name}
        type={type}
        className={className}
        value={value}
        onChange={onChange}
        required={required}
        {...rest}
      />
    </div>
  );
};

export default FormInput;
