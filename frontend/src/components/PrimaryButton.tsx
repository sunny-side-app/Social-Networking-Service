import React from "react";
import "../style/PrimaryButton.css";

interface Props {
  label: string;
  onClick?: () => void;
  disabled?: boolean;
}

function PrimaryButton({ label, onClick, disabled }: Props) {
  return (
    <button
      className="primaryButton"
      onClick={onClick}
      disabled={disabled}
    >
      {label}
    </button>
  );
}

export default PrimaryButton;
