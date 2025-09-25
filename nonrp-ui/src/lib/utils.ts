import { clsx, ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";

declare namespace window {
    function invokeNative(type: string, url: string,): void
}

declare function GetParentResourceName(): string;

export function cn(...inputs: ClassValue[]) {
    return twMerge(clsx(inputs));
}

export function openUrl (url: string): void {
    window.invokeNative('openUrl', url);
}

export function getApiEndpoint() {
    return `https://${GetParentResourceName()}`;
}