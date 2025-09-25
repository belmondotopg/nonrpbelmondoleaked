import { cn } from "../lib/utils";

interface Props {
    size?: number;
    className?: string;
}

export const Logo = ({
    size,
    className
}: Props) => {
    return (
        <img
            src="https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/images/newscripts.png"
            alt=""
            className={cn(className)}
            style={{
                width: size ? `${size}px` : "auto",
            }}
        />
    )
}